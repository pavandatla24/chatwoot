class Messages::ContentEnricherService
  def initialize(message)
    @message = message
    @content = message.content.to_s.downcase
  end

  def perform
    enrich_content_attributes
  end

  private

  def enrich_content_attributes
    urgency = detect_urgency
    return unless urgency

    @message.content_attributes = @message.content_attributes.merge(
      {
        urgency: urgency,
        issue_type: detect_issue_type || 'general'
      }
    )
  end

  def detect_urgency
    return 'high' if @content.match?(/\b(urgent|emergency|critical|asap|immediate)\b/)
    return 'medium' if @content.match?(/\b(important|priority|attention)\b/)
    return 'low' if @content.match?(/\b(minor|low|whenever|routine)\b/)

    nil
  end

  def detect_issue_type
    return 'technical' if @content.match?(/\b(bug|error|crash|issue|problem|not working)\b/)
    return 'billing' if @content.match?(/\b(payment|charge|bill|invoice|subscription|pricing)\b/)
    return 'feature' if @content.match?(/\b(feature|enhancement|suggestion|improvement)\b/)
    return 'question' if @content.match?(/\b(how|what|when|where|why|who|help|support)\b/)

    'general'
  end
end