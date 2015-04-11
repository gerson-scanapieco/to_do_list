class Ability
  include CanCan::Ability

  def initialize(user)
    # ToDoLists
    can :read, ToDoList, list_type: ToDoListTypes::PUBLIC
    can :manage, ToDoList, user_id: user.id

    # FavoriteToDoLists
    can [:create, :destroy], FavoriteToDoList, to_do_list_id: ToDoList.public_lists.merge(ToDoList.dont_belong_to_user(user)).pluck(:id)

    # Assignments
    can :manage, Assignment, to_do_list_id: user.to_do_list_ids
    can :read, Assignment, to_do_list_id: ToDoList.public_lists.pluck(:id)

    # User
    can [:read, :update], User, id: user.id
    can :read, User
  end
end
