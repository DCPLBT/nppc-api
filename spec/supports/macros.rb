def user_token(user)
  post user_session_url, params: { user: { login: user.email, password: user.password } }
  response.header['Authorization']
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
  fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png')
end
