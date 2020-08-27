def user_token(user)
  post user_session_url, params: { user: { login: user.email, password: user.password } }
  response.header['Authorization']
end

def header_params(args = {})
  { 'Authorization': args[:token], 'Accept': 'Application/json', 'HTTP_ACCEPT_LANGUAGE': args[:locale] || 'en' }
end

def json
  result = JSON.parse(response.body)
  result.is_a?(Array) ? result : HashWithIndifferentAccess.new(result)
end

def formatted_timestamp(time)
  time.strftime('%Y%m%d %H%M')
end

def formatted_date(date)
  date.strftime('%Y-%m-%d')
end

def load_task(task)
  Rails.application.load_tasks
  Rake::Task[task].execute
end

def sorted?(array)
  array.each_cons(2).all? { |a, b| (a <=> b) <= 0 }
end

def reverse_sorted?(array)
  array.each_cons(2).all? { |a, b| (a <=> b) >= 0 }
end

def image
  fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png')
end
