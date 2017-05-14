class RunPolicy < ApplicationPolicy

  class Scope < Scope
    # admin can see all runs, other type of current_users can only see themselves
    def resolve
      if current_user.admin?
        scope.all
      else
        scope.where(user_id: current_user.id)
      end
    end
  end
  
  def index?
    true
  end

  def create?
    true
  end

  # allowing user to show/edit/delete his runs  
  def show?
    super && (current_user_allowed_to_crud? || current_user.id == record.user_id)
  end
  
  def destroy?
    super && (current_user_allowed_to_crud? || current_user.id == record.user_id)
  end

  def update?
    super && (current_user_allowed_to_crud? || current_user.id == record.user_id)
  end

  def permitted_attributes
    # normal users can't change the run owner
    attributes = [:date, :duration, :distance, :avg_speed, :user_id]
    (current_user && current_user_allowed_to_crud?) ? attributes : (attributes - [:user_id])
  end

	def current_user_allowed_to_crud?
    current_user.admin?
  end
end
