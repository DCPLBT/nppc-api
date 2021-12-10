# frozen_string_literal: true

def sign_in(user)
  post user_session_url, params: { user: { login: user.email, password: user.password } }
  response.header
end

def sign_out
  delete destroy_user_session_url
end

def json
  result = JSON.parse(response.body)
  result.is_a?(Array) ? result : HashWithIndifferentAccess.new(result)
end

def load_task(task)
  Rails.application.load_tasks
  Rake::Task[task].execute
end

def image
  Rack::Test::UploadedFile.new(Rails.root.join('spec', 'supports', 'assets', 'image.png'), 'image/png')
end
