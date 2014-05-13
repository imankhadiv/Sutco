class Board < ActiveRecord::Base
  has_many :conversations, dependent: :destroy
  validates :title, presence: true
  belongs_to :show


# this method returns user id of people who have a role in a show.
  def self.board_users(board)
    @show_roles = ShowRole.select('id').where(show_id: board.show.id)
    @user_ids = RoleApplication.where(show_role_id: @show_roles, status: 'Approved').pluck(:user_id)
  end

  #this method is implemented to mange accessibility to different message boards. Only people who have applied for a role in a show can access its message board
  def authorized(user)
    if !public
      @show_roles = ShowRole.select('id').where(show_id: show_id)
      @user_ids = RoleApplication.where(show_role_id: @show_roles, status: 'Approved').pluck(:user_id)
      if @user_ids.include? user.id
        true
      else
        false
      end
    else
      true
    end
  end

end
