%w[owner co-user].each do |el|
  Role.create(name: el)
end

