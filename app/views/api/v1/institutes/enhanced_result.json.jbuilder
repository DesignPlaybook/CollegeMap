json.institutes do
  json.array! @institute_departments.each do |institute_department|
    json.name institute_department['institute_name']
    json.department_name institute_department['department_name']
  end
end

json.report @csv