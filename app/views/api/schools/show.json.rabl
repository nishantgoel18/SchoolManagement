collection @school

attributes :id, :name, :about, :address

child :batches do
  attributes :id, :name
  child :course do
    attributes :id, :name
  end
end

child :courses do
  attributes :id, :name
end

child(:school_admins) do |obj|
  attributes :id, :name, :email, :type
end