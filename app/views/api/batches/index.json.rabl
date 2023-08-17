collection @batches
attributes :id, :name, :email, :type

child :school do
  attributes :id, :name, :address, :about
end

child :students do
  attributes :id, :name, :email, :type
end