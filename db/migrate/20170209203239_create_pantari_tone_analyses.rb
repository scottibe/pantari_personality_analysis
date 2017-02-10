class CreatePantariToneAnalyses < ActiveRecord::Migration
  def change
    create_table :pantari_tone_analyses do |t|
      t.string :author
      t.integer :user_id
      t.integer :anger
      t.integer :disgust
      t.integer :fear
      t.integer :joy
      t.integer :sadness
      t.integer :analytical
      t.integer :confident
      t.integer :tentative
      t.integer :openness
      t.integer :conscientiousness
      t.integer :extraversion
      t.integer :agreeableness
      t.integer :emotional_range
      t.datetime
    end      
  end
end
