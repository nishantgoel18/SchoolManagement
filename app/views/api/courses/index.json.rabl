collection @courses

attributes :id, :name

child :school do
  attributes :id, :name, :address, :about
end