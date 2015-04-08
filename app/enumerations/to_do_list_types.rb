class ToDoListTypes < EnumerateIt::Base
  associate_values(
    private: [ 1, 'Privada' ],
    public: [ 2, 'Pública']
  )

  sort_by :value
end
