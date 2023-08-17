collection @school_admins

attributes :id, :name, :email, :type

child :school do
  attributes :id, :name, :address, :about
end