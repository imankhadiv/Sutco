# # == Schema Information
# #
# # Table name: show_dates
# #
# #


FactoryGirl.define do

  # post factory with a `belongs_to` association for the user
  factory :show_date do
    date  Date.tomorrow
    time  Time.now
    show
  end

  # user factory without associated posts
  factory :show do
    name "Show 1"
    director "Some Director"
    producer "Some Producer"
    synopsis "Some Description"
    stage_manager "Some Stage Manager"

    # user_with_posts will create post data after the user has been created
    factory :show_with_show_dates do
      # posts_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        show_dates_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |show, evaluator|
        create_list(:show_date, evaluator.show_dates_count, show: show)
      end
    end
  end
end