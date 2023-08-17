collection @course

attributes :id, :name

child :school do
  attributes :id, :name, :address, :about
end