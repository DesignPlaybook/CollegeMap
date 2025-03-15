# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Sample data for institutes
institutes_data = {
  institutes: [
    {
      slug: 'iitp',
      name: 'IIT Patna',
      address: 'Patna, Bihar',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'ece',
          name: 'Electronics and Communication Engineering'
        }
      ]
    },
    {
      slug: 'iitb',
      name: 'IIT Bombay',
      address: 'Mumbai, Maharashtra',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'me',
          name: 'Mechanical Engineering'
        }
      ]
    }
  ]
}

# Call the import_institutes method to seed the data
Institute.import_institutes(institutes_data)
