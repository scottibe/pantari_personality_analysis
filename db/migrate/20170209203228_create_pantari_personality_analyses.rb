class CreatePantariPersonalityAnalyses < ActiveRecord::Migration
  def change
    create_table :pantari_personality_analyses do |t|
      t.string :author
      t.integer :user_id
      t.integer :word_count
      t.integer :agreeableness
      t.integer :conscientiousness
      t.integer :extraversion
      t.integer :emotional_range
      t.integer :openness
      t.integer :challenge
      t.integer :closeness
      t.integer :curiosity
      t.integer :excitement
      t.integer :harmony
      t.integer :ideal
      t.integer :liberty
      t.integer :love
      t.integer :practicality
      t.integer :self_expression
      t.integer :stability
      t.integer :structure
      t.integer :conservation
      t.integer :openness_to_change
      t.integer :hedonism
      t.integer :self_enhancement
      t.integer :self_transcendence
    end 
  end
end
