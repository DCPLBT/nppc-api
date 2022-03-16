# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_316_105_531) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'action_text_rich_texts', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'body'
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.string 'service_name', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'agencies', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.bigint 'employee_type_id'
    t.index ['employee_type_id'], name: 'index_agencies_on_employee_type_id'
    t.index ['user_id'], name: 'index_agencies_on_user_id'
  end

  create_table 'attachments', force: :cascade do |t|
    t.boolean 'default', default: false
    t.string 'type'
    t.string 'attachable_type', null: false
    t.bigint 'attachable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[attachable_type attachable_id], name: 'index_attachments_on_attachable_type_and_attachable_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.string 'cartable_type', null: false
    t.bigint 'cartable_id', null: false
    t.decimal 'quantity'
    t.decimal 'amount'
    t.bigint 'session_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'category'
    t.index %w[cartable_type cartable_id], name: 'index_carts_on_cartable'
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['user_id'], name: 'index_companies_on_user_id'
  end

  create_table 'designations', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.bigint 'agency_id'
    t.index ['agency_id'], name: 'index_designations_on_agency_id'
    t.index ['user_id'], name: 'index_designations_on_user_id'
  end

  create_table 'distributions', force: :cascade do |t|
    t.bigint 'region_id'
    t.bigint 'district_id'
    t.bigint 'extension_id'
    t.bigint 'company_id'
    t.bigint 'user_id', null: false
    t.integer 'distributed_type'
    t.string 'consumer_ids', array: true
    t.integer 'state'
    t.string 'reference_no'
    t.boolean 'draft'
    t.string 'consumer_cid'
    t.string 'consumer_name'
    t.string 'consumer_village'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'from_id'
    t.bigint 'to_id'
    t.bigint 'village_id'
    t.index ['company_id'], name: 'index_distributions_on_company_id'
    t.index ['district_id'], name: 'index_distributions_on_district_id'
    t.index ['extension_id'], name: 'index_distributions_on_extension_id'
    t.index ['from_id'], name: 'index_distributions_on_from_id'
    t.index ['region_id'], name: 'index_distributions_on_region_id'
    t.index ['to_id'], name: 'index_distributions_on_to_id'
    t.index ['user_id'], name: 'index_distributions_on_user_id'
    t.index ['village_id'], name: 'index_distributions_on_village_id'
  end

  create_table 'districts', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.bigint 'region_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['region_id'], name: 'index_districts_on_region_id'
    t.index ['user_id'], name: 'index_districts_on_user_id'
  end

  create_table 'employee_types', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.bigint 'role_id'
    t.index ['role_id'], name: 'index_employee_types_on_role_id'
    t.index ['user_id'], name: 'index_employee_types_on_user_id'
  end

  create_table 'extensions', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.bigint 'district_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['district_id'], name: 'index_extensions_on_district_id'
    t.index ['user_id'], name: 'index_extensions_on_user_id'
  end

  create_table 'forwardable_forwarded_tos', force: :cascade do |t|
    t.string 'forwardable_type', null: false
    t.bigint 'forwardable_id', null: false
    t.bigint 'forwarded_to_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[forwardable_type forwardable_id], name: 'index_forwardable_forwarded_tos_on_forwardable'
    t.index ['forwarded_to_id'], name: 'index_forwardable_forwarded_tos_on_forwarded_to_id'
  end

  create_table 'groups', force: :cascade do |t|
    t.string 'name'
    t.bigint 'role_id', null: false
    t.bigint 'region_id'
    t.bigint 'district_id'
    t.bigint 'extension_id'
    t.bigint 'village_id'
    t.bigint 'company_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'individual_id'
    t.index ['company_id'], name: 'index_groups_on_company_id'
    t.index ['district_id'], name: 'index_groups_on_district_id'
    t.index ['extension_id'], name: 'index_groups_on_extension_id'
    t.index ['individual_id'], name: 'index_groups_on_individual_id'
    t.index ['region_id'], name: 'index_groups_on_region_id'
    t.index ['role_id'], name: 'index_groups_on_role_id'
    t.index ['village_id'], name: 'index_groups_on_village_id'
  end

  create_table 'indents', force: :cascade do |t|
    t.bigint 'region_id'
    t.bigint 'district_id'
    t.bigint 'extension_id'
    t.bigint 'company_id'
    t.bigint 'user_id', null: false
    t.boolean 'draft'
    t.integer 'state'
    t.string 'reference_no'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'from_id'
    t.bigint 'to_id'
    t.bigint 'accepted_by_id'
    t.datetime 'accepted_on'
    t.integer 'indent_type'
    t.index ['accepted_by_id'], name: 'index_indents_on_accepted_by_id'
    t.index ['company_id'], name: 'index_indents_on_company_id'
    t.index ['district_id'], name: 'index_indents_on_district_id'
    t.index ['extension_id'], name: 'index_indents_on_extension_id'
    t.index ['region_id'], name: 'index_indents_on_region_id'
    t.index ['user_id'], name: 'index_indents_on_user_id'
  end

  create_table 'line_items', force: :cascade do |t|
    t.bigint 'product_type_id', null: false
    t.bigint 'product_id', null: false
    t.bigint 'unit_id', null: false
    t.bigint 'stock_id'
    t.string 'itemable_type', null: false
    t.bigint 'itemable_id', null: false
    t.decimal 'quantity'
    t.decimal 'unit_price'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'received_by_id'
    t.boolean 'received', default: false
    t.datetime 'received_on'
    t.decimal 'received_quantity'
    t.index %w[itemable_type itemable_id], name: 'index_line_items_on_itemable'
    t.index ['product_id'], name: 'index_line_items_on_product_id'
    t.index ['product_type_id'], name: 'index_line_items_on_product_type_id'
    t.index ['received_by_id'], name: 'index_line_items_on_received_by_id'
    t.index ['stock_id'], name: 'index_line_items_on_stock_id'
    t.index ['unit_id'], name: 'index_line_items_on_unit_id'
  end

  create_table 'mobilizations', force: :cascade do |t|
    t.bigint 'region_id'
    t.bigint 'district_id'
    t.bigint 'extension_id'
    t.bigint 'company_id'
    t.bigint 'user_id', null: false
    t.bigint 'approved_by_id'
    t.integer 'category'
    t.integer 'state'
    t.string 'reference_no'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'received_by_id'
    t.datetime 'received_on'
    t.datetime 'approved_on'
    t.bigint 'from_id'
    t.bigint 'to_id'
    t.bigint 'rejected_by_id'
    t.datetime 'rejected_on'
    t.index ['approved_by_id'], name: 'index_mobilizations_on_approved_by_id'
    t.index ['company_id'], name: 'index_mobilizations_on_company_id'
    t.index ['district_id'], name: 'index_mobilizations_on_district_id'
    t.index ['extension_id'], name: 'index_mobilizations_on_extension_id'
    t.index ['from_id'], name: 'index_mobilizations_on_from_id'
    t.index ['received_by_id'], name: 'index_mobilizations_on_received_by_id'
    t.index ['region_id'], name: 'index_mobilizations_on_region_id'
    t.index ['rejected_by_id'], name: 'index_mobilizations_on_rejected_by_id'
    t.index ['to_id'], name: 'index_mobilizations_on_to_id'
    t.index ['user_id'], name: 'index_mobilizations_on_user_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.string 'title'
    t.string 'url'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'photos', force: :cascade do |t|
    t.boolean 'default', default: false
    t.string 'type'
    t.string 'imageable_type', null: false
    t.bigint 'imageable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[imageable_type imageable_id], name: 'index_photos_on_imageable_type_and_imageable_id'
  end

  create_table 'product_types', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['user_id'], name: 'index_product_types_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'unit_id', null: false
    t.bigint 'user_id', null: false
    t.bigint 'product_type_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['product_type_id'], name: 'index_products_on_product_type_id'
    t.index ['unit_id'], name: 'index_products_on_unit_id'
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'profiles', force: :cascade do |t|
    t.integer 'gender'
    t.string 'employee_id'
    t.bigint 'region_id'
    t.bigint 'district_id'
    t.bigint 'extension_id'
    t.bigint 'company_id'
    t.bigint 'user_id', null: false
    t.bigint 'employee_type_id'
    t.bigint 'designation_id'
    t.bigint 'agency_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'occupation'
    t.date 'dob'
    t.string 'mother_name'
    t.string 'father_name'
    t.string 'middlename'
    t.string 'name'
    t.bigint 'village_id'
    t.index ['agency_id'], name: 'index_profiles_on_agency_id'
    t.index ['company_id'], name: 'index_profiles_on_company_id'
    t.index ['designation_id'], name: 'index_profiles_on_designation_id'
    t.index ['district_id'], name: 'index_profiles_on_district_id'
    t.index ['employee_type_id'], name: 'index_profiles_on_employee_type_id'
    t.index ['extension_id'], name: 'index_profiles_on_extension_id'
    t.index ['region_id'], name: 'index_profiles_on_region_id'
    t.index ['user_id'], name: 'index_profiles_on_user_id'
    t.index ['village_id'], name: 'index_profiles_on_village_id'
  end

  create_table 'recipients', force: :cascade do |t|
    t.bigint 'notification_id', null: false
    t.bigint 'user_id', null: false
    t.boolean 'read', default: false
    t.datetime 'read_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['notification_id'], name: 'index_recipients_on_notification_id'
    t.index ['user_id'], name: 'index_recipients_on_user_id'
  end

  create_table 'regions', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['user_id'], name: 'index_regions_on_user_id'
  end

  create_table 'requestable_requesters', force: :cascade do |t|
    t.string 'requestable_type', null: false
    t.bigint 'requestable_id', null: false
    t.bigint 'requester_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[requestable_type requestable_id], name: 'index_requestable_requesters_on_requestable'
    t.index ['requester_id'], name: 'index_requestable_requesters_on_requester_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'description'
  end

  create_table 'roles_users', id: false, force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'role_id', null: false
  end

  create_table 'settings', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.jsonb 'meta'
    t.integer 'category'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_settings_on_user_id'
  end

  create_table 'stocks', force: :cascade do |t|
    t.bigint 'product_type_id', null: false
    t.bigint 'product_id', null: false
    t.bigint 'user_id', null: false
    t.bigint 'unit_id', null: false
    t.decimal 'quantity'
    t.decimal 'unit_price'
    t.date 'expiry_date'
    t.date 'procured_on'
    t.date 'obsolete_date'
    t.text 'remark'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'group_id'
    t.index ['group_id'], name: 'index_stocks_on_group_id'
    t.index ['product_id'], name: 'index_stocks_on_product_id'
    t.index ['product_type_id'], name: 'index_stocks_on_product_type_id'
    t.index ['unit_id'], name: 'index_stocks_on_unit_id'
    t.index ['user_id'], name: 'index_stocks_on_user_id'
  end

  create_table 'surrenders', force: :cascade do |t|
    t.bigint 'region_id'
    t.bigint 'district_id'
    t.bigint 'extension_id'
    t.bigint 'user_id', null: false
    t.integer 'surrender_type'
    t.integer 'state'
    t.string 'reference_no'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'received_by_id'
    t.datetime 'received_on'
    t.bigint 'from_id'
    t.bigint 'to_id'
    t.index ['district_id'], name: 'index_surrenders_on_district_id'
    t.index ['extension_id'], name: 'index_surrenders_on_extension_id'
    t.index ['from_id'], name: 'index_surrenders_on_from_id'
    t.index ['received_by_id'], name: 'index_surrenders_on_received_by_id'
    t.index ['region_id'], name: 'index_surrenders_on_region_id'
    t.index ['to_id'], name: 'index_surrenders_on_to_id'
    t.index ['user_id'], name: 'index_surrenders_on_user_id'
  end

  create_table 'units', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['user_id'], name: 'index_units_on_user_id'
  end

  create_table 'user_groups', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'group_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['group_id'], name: 'index_user_groups_on_group_id'
    t.index ['user_id'], name: 'index_user_groups_on_user_id'
  end

  create_table 'user_stocks', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'stock_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['stock_id'], name: 'index_user_stocks_on_stock_id'
    t.index ['user_id'], name: 'index_user_stocks_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.string 'username'
    t.string 'phone'
    t.boolean 'active', default: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.bigint 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.string 'cid'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['invitation_token'], name: 'index_users_on_invitation_token', unique: true
    t.index ['invitations_count'], name: 'index_users_on_invitations_count'
    t.index ['invited_by_id'], name: 'index_users_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_users_on_invited_by_type_and_invited_by_id'
    t.index ['phone'], name: 'index_users_on_phone', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_users_on_unlock_token', unique: true
    t.index ['username'], name: 'index_users_on_username', unique: true
  end

  create_table 'videos', force: :cascade do |t|
    t.boolean 'default', default: false
    t.string 'type'
    t.string 'clipable_type', null: false
    t.bigint 'clipable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[clipable_type clipable_id], name: 'index_videos_on_clipable_type_and_clipable_id'
  end

  create_table 'villages', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.bigint 'user_id', null: false
    t.bigint 'extension_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'disabled', default: false
    t.index ['extension_id'], name: 'index_villages_on_extension_id'
    t.index ['user_id'], name: 'index_villages_on_user_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'agencies', 'employee_types'
  add_foreign_key 'agencies', 'users'
  add_foreign_key 'companies', 'users'
  add_foreign_key 'designations', 'agencies'
  add_foreign_key 'designations', 'users'
  add_foreign_key 'distributions', 'companies'
  add_foreign_key 'distributions', 'districts'
  add_foreign_key 'distributions', 'extensions'
  add_foreign_key 'distributions', 'regions'
  add_foreign_key 'distributions', 'users'
  add_foreign_key 'distributions', 'villages'
  add_foreign_key 'districts', 'regions'
  add_foreign_key 'districts', 'users'
  add_foreign_key 'employee_types', 'roles'
  add_foreign_key 'employee_types', 'users'
  add_foreign_key 'extensions', 'districts'
  add_foreign_key 'extensions', 'users'
  add_foreign_key 'groups', 'companies'
  add_foreign_key 'groups', 'districts'
  add_foreign_key 'groups', 'extensions'
  add_foreign_key 'groups', 'regions'
  add_foreign_key 'groups', 'roles'
  add_foreign_key 'groups', 'villages'
  add_foreign_key 'indents', 'companies'
  add_foreign_key 'indents', 'districts'
  add_foreign_key 'indents', 'extensions'
  add_foreign_key 'indents', 'regions'
  add_foreign_key 'indents', 'users'
  add_foreign_key 'line_items', 'product_types'
  add_foreign_key 'line_items', 'products'
  add_foreign_key 'line_items', 'stocks'
  add_foreign_key 'line_items', 'units'
  add_foreign_key 'mobilizations', 'companies'
  add_foreign_key 'mobilizations', 'districts'
  add_foreign_key 'mobilizations', 'extensions'
  add_foreign_key 'mobilizations', 'regions'
  add_foreign_key 'mobilizations', 'users'
  add_foreign_key 'product_types', 'users'
  add_foreign_key 'products', 'product_types'
  add_foreign_key 'products', 'units'
  add_foreign_key 'products', 'users'
  add_foreign_key 'profiles', 'agencies'
  add_foreign_key 'profiles', 'companies'
  add_foreign_key 'profiles', 'designations'
  add_foreign_key 'profiles', 'districts'
  add_foreign_key 'profiles', 'employee_types'
  add_foreign_key 'profiles', 'extensions'
  add_foreign_key 'profiles', 'regions'
  add_foreign_key 'profiles', 'users'
  add_foreign_key 'profiles', 'villages'
  add_foreign_key 'recipients', 'notifications'
  add_foreign_key 'recipients', 'users'
  add_foreign_key 'regions', 'users'
  add_foreign_key 'settings', 'users'
  add_foreign_key 'stocks', 'groups'
  add_foreign_key 'stocks', 'product_types'
  add_foreign_key 'stocks', 'products'
  add_foreign_key 'stocks', 'units'
  add_foreign_key 'stocks', 'users'
  add_foreign_key 'surrenders', 'districts'
  add_foreign_key 'surrenders', 'extensions'
  add_foreign_key 'surrenders', 'regions'
  add_foreign_key 'surrenders', 'users'
  add_foreign_key 'units', 'users'
  add_foreign_key 'user_groups', 'groups'
  add_foreign_key 'user_groups', 'users'
  add_foreign_key 'user_stocks', 'stocks'
  add_foreign_key 'user_stocks', 'users'
  add_foreign_key 'villages', 'extensions'
  add_foreign_key 'villages', 'users'
end
