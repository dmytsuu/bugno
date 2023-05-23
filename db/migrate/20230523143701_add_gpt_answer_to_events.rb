class AddGptAnswerToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :gpt_answer, :string
  end
end
