json.institutes do
  json.array! @institutes.each do |institute|
    json.id institute.id
    json.name institute.name
    json.address institute.address
    json.departments do
      json.array! institute.departments.each do |department|
        json.id department.id
        json.name department.name
      end
    end
  end
end