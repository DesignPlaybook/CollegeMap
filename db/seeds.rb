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
    },
    {
      slug: 'iitd',
      name: 'IIT Delhi',
      address: 'New Delhi, Delhi',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'ece',
          name: 'Electronics and Communication Engineering'
        },
        {
          slug: 'me',
          name: 'Mechanical Engineering'
        },
        {
          slug: 'ee',
          name: 'Electrical Engineering'
        },
        {
          slug: 'ce',
          name: 'Civil Engineering'
        },
        {
          slug: 'ch',
          name: 'Chemical Engineering'
        }
      ]
    },
    {
      slug: 'iitk',
      name: 'IIT Kanpur',
      address: 'Kanpur, Uttar Pradesh',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'ece',
          name: 'Electronics and Communication Engineering'
        },
        {
          slug: 'me',
          name: 'Mechanical Engineering'
        },
        {
          slug: 'ee',
          name: 'Electrical Engineering'
        },
        {
          slug: 'ce',
          name: 'Civil Engineering'
        },
        {
          slug: 'ch',
          name: 'Chemical Engineering'
        },
        {
          slug: 'ae',
          name: 'Aerospace Engineering'
        }
      ]
    },
    {
      slug: 'iitm',
      name: 'IIT Madras',
      address: 'Chennai, Tamil Nadu',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'ece',
          name: 'Electronics and Communication Engineering'
        },
        {
          slug: 'me',
          name: 'Mechanical Engineering'
        },
        {
          slug: 'ee',
          name: 'Electrical Engineering'
        },
        {
          slug: 'ce',
          name: 'Civil Engineering'
        },
        {
          slug: 'ch',
          name: 'Chemical Engineering'
        },
        {
          slug: 'ae',
          name: 'Aerospace Engineering'
        },
        {
          slug: 'bi',
          name: 'Biotechnology'
        }
      ]
    },
    {
      slug: 'iitg',
      name: 'IIT Guwahati',
      address: 'Guwahati, Assam',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'ece',
          name: 'Electronics and Communication Engineering'
        },
        {
          slug: 'me',
          name: 'Mechanical Engineering'
        },
        {
          slug: 'ee',
          name: 'Electrical Engineering'
        },
        {
          slug: 'ce',
          name: 'Civil Engineering'
        },
        {
          slug: 'ch',
          name: 'Chemical Engineering'
        },
        {
          slug: 'ae',
          name: 'Aerospace Engineering'
        },
        {
          slug: 'bi',
          name: 'Biotechnology'
        },
        {
          slug: 'mt',
          name: 'Materials Science and Engineering'
        }
      ]
    },
    {
      slug: 'iitr',
      name: 'IIT Roorkee',
      address: 'Roorkee, Uttarakhand',
      departments: [
        {
          slug: 'cse',
          name: 'Computer Science and Engineering'
        },
        {
          slug: 'ece',
          name: 'Electronics and Communication Engineering'
        },
        {
          slug: 'me',
          name: 'Mechanical Engineering'
        },
        {
          slug: 'ee',
          name: 'Electrical Engineering'
        },
        {
          slug: 'ce',
          name: 'Civil Engineering'
        },
        {
          slug: 'ch',
          name: 'Chemical Engineering'
        },
        {
          slug: 'ae',
          name: 'Aerospace Engineering'
        },
        {
          slug: 'bi',
          name: 'Biotechnology'
        },
        {
          slug: 'mt',
          name: 'Materials Science and Engineering'
        },
        {
          slug: 'pe',
          name: 'Petroleum Engineering'
        }
      ]
    }
  ]
}

# Call the import_institutes method to seed the data
Institute.import_institutes(institutes_data)
