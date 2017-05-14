describe RunPolicy, type: :policy do

  let (:current_user) { create :user }
  let (:other_user) { create :user }
  let (:admin) { create :user, :admin }
  let (:manager) { create :user, :manager }
  
  let (:current_user_run) { create(:run, user: current_user) }
  let (:other_user_run) { create(:run, user: other_user) }

  
  subject { RunPolicy }

  permissions :index? do
    it "allows access for any type of user" do
      expect(subject).to permit(current_user)
      expect(subject).to permit(manager)
      expect(subject).to permit(admin)
    end
  end

  # we need persisted user, because we check against the database
  permissions :show? do
    it "prevents other users from seeing your runs" do
      expect(subject).not_to permit(current_user, other_user_run)
    end
    it "allows you to see your own runs" do
      expect(subject).to permit(current_user, current_user_run)
    end
    it "allows an admin but not manager to see any run" do
      expect(subject).to permit(admin, other_user_run)
      expect(subject).not_to permit(manager, other_user_run)
    end
  end

  permissions :update? do
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, other_user_run)
    end
    it "allows user to update his runs" do
      expect(subject).to permit(current_user, current_user_run)
    end
    it "prevents user from updating others runs" do
      expect(subject).not_to permit(current_user, other_user_run)
    end    
    it "allows an admin but not manager to update any run" do
      expect(subject).to permit(admin, other_user_run)
      expect(subject).not_to permit(manager, other_user_run)
    end
  end

  permissions :destroy? do
    # currently user is allowed to delete himself
    # it "prevents deleting yourself" do
    #   expect(subject).not_to permit(current_user, current_user)
    # end
    it "allows user to delete his runs" do
      expect(subject).to permit(current_user, current_user_run)
    end
    it "prevents user from deleting another users runs" do
      expect(subject).not_to permit(current_user, other_user_run)
    end    
    it "allows an admin but not manager to delete any run" do
      expect(subject).to permit(admin, other_user_run)
      expect(subject).not_to permit(manager, other_user_run)
    end
  end

end
