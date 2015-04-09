class Ability
  include CanCan::Ability

  def initialize(user)
    # ToDoLists
    can :read, ToDoList, list_type: ToDoListTypes::PUBLIC
    can :manage, ToDoList, user_id: user.id

    # User
    can [:read, :update], User, id: user.id
    can :read, User
  end
end
