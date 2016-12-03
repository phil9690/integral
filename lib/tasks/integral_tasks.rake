namespace :integral do

  # Generates posts used for demos and testing
  #
  # Usage: be rake integral:generate_posts[100]
  #
  desc "Generates Post objects used for demos and testing"
  task :generate_posts, [:amount] => [:environment] do |t, args|
    amount_of_posts = args[:amount].to_i
    amount_of_posts = 10 if amount_of_posts == 0

    puts "Generating #{amount_of_posts} sample posts.."

    amount_of_posts.times do
      FactoryGirl.create(:integral_post)
    end

    puts 'Complete.'
  end
end
