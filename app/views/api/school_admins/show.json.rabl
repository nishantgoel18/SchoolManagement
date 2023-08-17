collection @school_admin

attributes :id, :name, :email, :type

child :school do
  attributes :id, :name, :address, :about
end