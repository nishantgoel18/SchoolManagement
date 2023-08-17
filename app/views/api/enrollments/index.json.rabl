collection @enrollments
attributes :id, :status

child :student do
  attributes :id, :name, :email, :type
end

child :batch do
  attributes :id, :name
  child :course do
    attributes :id, :name
  end
end