# Create User Roles
Integral::Role.create!(name: 'UserManager')
Integral::Role.create!(name: 'ImageManager')
Integral::Role.create!(name: 'PageManager')
Integral::Role.create!(name: 'PostManager')

# Demo User
Integral::User.create!({ name: 'Integrico', email: 'info@integralrails.com', password: 'password', role_ids: Integral::Role.ids })

# Demo Page
Integral::Page.create!(title: 'Integral Demo Page',
                       description:'This is the Integral gem demo page which should be replaced.',
                       path: '/demo',
                       body: 'Welcome to Integral. Replace this page by logging in and creating your own!')
