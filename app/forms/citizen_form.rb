# frozen_string_literal: true

class CitizenForm < BaseForm
  attr_accessor :district, :extension, :village, :cid

  def show
    citizen
  end

  private

  def citizen
    @citizen ||= fetch_citizen_detail
  end

  def fetch_citizen_detail # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    detail = CitizenService.new(cid).run
    return User.new unless detail

    @district ||= district_from_name(detail[:dzongkhagName])
    @extension ||= extension_from_name(detail[:gewogName])

    User.new(
      cid: cid,
      phone: detail[:mobileNumber],
      profile_attributes: {
        firstname: detail[:firstName],
        lastname: detail[:lastName],
        gender: detail[:gender].eql?('M') ? :male : :female,
        mother_name: detail[:motherName],
        father_name: detail[:fatherName],
        district_id: district&.id,
        extension_id: extension&.id,
        village: detail[:villageName],
        occupation: detail[:occupation],
        dob: detail[:dob]
      }
    )
  end

  def district_from_name(name)
    District.find do |s|
      Text::Soundex.soundex(s.name).eql?(Text::Soundex.soundex(name)) ||
        Text::Levenshtein.distance(s.name, name) <= 3
    end
  end

  def extension_from_name(name)
    district&.extensions&.find do |s|
      Text::Soundex.soundex(s.name).eql?(Text::Soundex.soundex(name)) ||
        Text::Levenshtein.distance(s.name, name) <= 3
    end
  end
end
