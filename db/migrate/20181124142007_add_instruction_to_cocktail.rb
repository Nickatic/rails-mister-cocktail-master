class AddInstructionToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :instruction, :string
  end
end
