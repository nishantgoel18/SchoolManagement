collection @student

attributes :id, :name, :email, :type

child :school do
  attributes :id, :name, :address, :about
end

child :batches do
  attributes :id, :name
  child :course do
    attributes :id, :name
  end
end

child(:classmates) do |obj|
  attributes :id, :name, :email, :type
end