class TonalDescriptions

  attr_accessor :emotion_tone, :social_tone, :language_tone


  def emotion_tone
    emotion_tone = {
    :joy => "Joy or happiness has shades of enjoyment, satisfaction and pleasure. There is a sense of well-being, inner peace, love, safety and contentment.",
    :fear => "A response to impending danger. It is a survival mechanism that is a reaction to some negative stimulus. It may be a mild caution or an extreme phobia.",
    :sadness => "Indicates a feeling of loss and disadvantage. When a person can be observed to be quiet, less energetic and withdrawn, it may be inferred that sadness exists.",
    :disgust => "An emotional response of revulsion to something considered offensive or unpleasant. It is a sensation that refers to something revolting.",
    :anger => "Evoked due to injustice, conflict, humiliation, negligence or betrayal. If anger is active, the individual attacks the target, verbally or physically. If anger is passive, the person silently sulks and feels tension and hostility."
    }
  end  

  def social_tone
    social_tone = {
    :openness => "The extent a person is open to experience a variety of activities.",
    :open_low => "More likely to be perceived as no-nonsense, straightforward, blunt, or preferring tradition and the obvious over the complex, ambiguous, and subtle.",
    :open_high => "More likely to be perceived as intellectual, curious, emotionally-aware, imaginative, willing to try new things, appreciating beauty, or open to change.",
  
    :conscientiousness => "The tendency to act in an organized or thoughtful way.",
    :cons_lows => "More likely to be perceived as spontaneous, laid-back, reckless, unmethodical, remiss, or disorganized.",
    :cons_high => "More likely to be perceived as disciplined, dutiful, achievement-striving, confident, driven, or organized.",
  
    :extraversion => "The tendency to seek stimulation in the company of others.",
    :extra_low => "More likely to be perceived as independent, timid, introverted, restrained, boring, or dreary.",
    :extra_high => "More likely to be perceived as engaging, seeking attention, needy, assertive, outgoing, sociable, cheerful, excitement-seeking, or busy.",
  
    :agreeableness => "The tendency to be compassionate and cooperative towards others.",
    :agree_low => "More likely to be perceived as selfish, uncaring, uncooperative, self-interested, confrontational, skeptical, or arrogant.",
    :agree_high => "More likely to be perceived as caring, sympathetic, cooperative, compromising, trustworthy, or humble.",
  
    :emotional_range_or_neuroticism => "The extent a person's emotion is sensitive to the environment.",
    :emotional_low => "More likely to be perceived as calm, bland, content, relaxed, unconcerned, or careful.",
    :emotional_high => "More likely to be perceived as concerned, frustrated, angry, passionate, upset, stressed, insecure, or impulsive."
    }
  end

  def language_tone
    language_tone = {
    :analytical =>  "A person's reasoning and analytical attitude about things.",
    :analytical_low => "Little or no evidence of analytical tone.",
    :analytical_high => "More likely to be perceived as intellectual, rational, systematic, emotionless, or impersonal.",

    :confidence =>  "A person's degree of certainty.",
    :confidence_low => "Little or no evidence of confidence in tone.",
    :confidence_high => "More likely to be perceived as assured, collected, hopeful, or egotistical.",

    :tentative => "A person's degree of inhibition.",
    :tenative_low => "Little or no evidence of tentativeness in tone.",
    :tenative_high => "More likely to be perceived as questionable, doubtful, or debatable."
    }
  end

end



