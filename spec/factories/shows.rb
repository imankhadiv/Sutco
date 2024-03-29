# # == Schema Information
# #
# # Table name: show_dates
# #
# #


FactoryGirl.define do

  # show_date factory with a `belongs_to` association for the show
  factory :show_date do
    date  Date.tomorrow
    time  Time.now
    show
  end

  factory :show_role do
    position "Lighting operator"
    required_number  2
    show
  end

  # show factory without associated show_dates
  factory :show do
    name "Show 1"
    director "Some Director"
    producer "Some Producer"
    synopsis "Some Description"
    stage_manager "Some Stage Manager"

    # show_with_show_dates will create show_date data after the show has been created
    factory :show_with_show_dates do
      # show_dates_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        show_dates_count 1
      end
      # the after(:create) yields two values; the show instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the show is associated properly to the show_date
      after(:create) do |show, evaluator|
        create_list(:show_date, evaluator.show_dates_count, show: show)
      end
    end

    factory :show_with_show_roles do
      # show_roles_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        show_roles_count 1
      end
      # the after(:create) yields two values; the show instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the show is associated properly to the show_role
      after(:create) do |show, evaluator|
        create_list(:show_role, evaluator.show_roles_count, show: show)
      end
    end

    factory :show_with_show_roles_show_dates do
      # show_roles_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        show_dates_count 1
      end

      ignore do
        show_roles_count 1
      end
      # the after(:create) yields two values; the show instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the show is associated properly to the show_role
      after(:create) do |show, evaluator|
        create_list(:show_date, evaluator.show_dates_count, show: show)
        create_list(:show_role, evaluator.show_roles_count, show: show)
      end
    end

  end
end