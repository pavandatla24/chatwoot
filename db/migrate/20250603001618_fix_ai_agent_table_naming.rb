class FixAiAgentTableNaming < ActiveRecord::Migration[7.0]
  def up
    # Drop old indexes
    remove_index :aiAgent_inboxes, name: 'index_aiAgent_inboxes_on_aiAgent_topic_id'
    remove_index :aiAgent_inboxes, name: 'index_aiAgent_inboxes_on_aiAgent_topic_id_and_inbox_id'
    remove_index :aiAgent_inboxes, name: 'index_aiAgent_inboxes_on_inbox_id'

    remove_index :aiAgent_documents, name: 'index_aiAgent_documents_on_account_id'
    remove_index :aiAgent_documents, name: 'index_aiAgent_documents_on_topic_id'
    remove_index :aiAgent_documents, name: 'index_aiAgent_documents_on_topic_id_and_external_link'
    remove_index :aiAgent_documents, name: 'index_aiAgent_documents_on_status'

    remove_index :aiAgent_topic_responses, name: 'index_aiAgent_topic_responses_on_account_id'
    remove_index :aiAgent_topic_responses, name: 'index_aiAgent_topic_responses_on_topic_id'
    remove_index :aiAgent_topic_responses, name: 'index_aiAgent_topic_responses_on_status'
    remove_index :aiAgent_topic_responses, name: 'idx_cap_asst_resp_on_documentable'
    execute 'DROP INDEX vector_idx_knowledge_entries_embedding'

    remove_index :aiAgent_topics, name: 'index_aiAgent_topics_on_account_id'

    # Rename tables to use consistent ai_agent prefix
    rename_table :aiAgent_documents, :ai_agent_documents
    rename_table :aiAgent_inboxes, :ai_agent_inboxes
    rename_table :aiAgent_topic_responses, :ai_agent_topic_responses
    rename_table :aiAgent_topics, :ai_agent_topics

    # Update foreign key references
    rename_column :ai_agent_inboxes, :aiAgent_topic_id, :ai_agent_topic_id

    # Create new indexes
    add_index :ai_agent_inboxes, :ai_agent_topic_id, name: 'index_ai_agent_inboxes_on_ai_agent_topic_id'
    add_index :ai_agent_inboxes, [:ai_agent_topic_id, :inbox_id], name: 'index_ai_agent_inboxes_on_ai_agent_topic_id_and_inbox_id', unique: true
    add_index :ai_agent_inboxes, :inbox_id, name: 'index_ai_agent_inboxes_on_inbox_id'

    add_index :ai_agent_documents, :account_id, name: 'index_ai_agent_documents_on_account_id'
    add_index :ai_agent_documents, :topic_id, name: 'index_ai_agent_documents_on_topic_id'
    add_index :ai_agent_documents, [:topic_id, :external_link], name: 'index_ai_agent_documents_on_topic_id_and_external_link', unique: true
    add_index :ai_agent_documents, :status, name: 'index_ai_agent_documents_on_status'

    add_index :ai_agent_topic_responses, :account_id, name: 'index_ai_agent_topic_responses_on_account_id'
    add_index :ai_agent_topic_responses, :topic_id, name: 'index_ai_agent_topic_responses_on_topic_id'
    add_index :ai_agent_topic_responses, :status, name: 'index_ai_agent_topic_responses_on_status'
    add_index :ai_agent_topic_responses, [:documentable_type, :documentable_id], name: 'index_ai_agent_topic_responses_on_documentable'
    execute 'CREATE INDEX vector_idx_knowledge_entries_embedding ON ai_agent_topic_responses USING ivfflat (embedding vector_cosine_ops)'

    add_index :ai_agent_topics, :account_id, name: 'index_ai_agent_topics_on_account_id'
  end

  def down
    # Drop new indexes
    remove_index :ai_agent_inboxes, name: 'index_ai_agent_inboxes_on_ai_agent_topic_id'
    remove_index :ai_agent_inboxes, name: 'index_ai_agent_inboxes_on_ai_agent_topic_id_and_inbox_id'
    remove_index :ai_agent_inboxes, name: 'index_ai_agent_inboxes_on_inbox_id'

    remove_index :ai_agent_documents, name: 'index_ai_agent_documents_on_account_id'
    remove_index :ai_agent_documents, name: 'index_ai_agent_documents_on_topic_id'
    remove_index :ai_agent_documents, name: 'index_ai_agent_documents_on_topic_id_and_external_link'
    remove_index :ai_agent_documents, name: 'index_ai_agent_documents_on_status'

    remove_index :ai_agent_topic_responses, name: 'index_ai_agent_topic_responses_on_account_id'
    remove_index :ai_agent_topic_responses, name: 'index_ai_agent_topic_responses_on_topic_id'
    remove_index :ai_agent_topic_responses, name: 'index_ai_agent_topic_responses_on_status'
    remove_index :ai_agent_topic_responses, name: 'index_ai_agent_topic_responses_on_documentable'
    execute 'DROP INDEX vector_idx_knowledge_entries_embedding'

    remove_index :ai_agent_topics, name: 'index_ai_agent_topics_on_account_id'

    # Update foreign key references back
    rename_column :ai_agent_inboxes, :ai_agent_topic_id, :aiAgent_topic_id

    # Rename tables back to original names
    rename_table :ai_agent_documents, :aiAgent_documents
    rename_table :ai_agent_inboxes, :aiAgent_inboxes
    rename_table :ai_agent_topic_responses, :aiAgent_topic_responses
    rename_table :ai_agent_topics, :aiAgent_topics

    # Create old indexes
    add_index :aiAgent_inboxes, :aiAgent_topic_id, name: 'index_aiAgent_inboxes_on_aiAgent_topic_id'
    add_index :aiAgent_inboxes, [:aiAgent_topic_id, :inbox_id], name: 'index_aiAgent_inboxes_on_aiAgent_topic_id_and_inbox_id', unique: true
    add_index :aiAgent_inboxes, :inbox_id, name: 'index_aiAgent_inboxes_on_inbox_id'

    add_index :aiAgent_documents, :account_id, name: 'index_aiAgent_documents_on_account_id'
    add_index :aiAgent_documents, :topic_id, name: 'index_aiAgent_documents_on_topic_id'
    add_index :aiAgent_documents, [:topic_id, :external_link], name: 'index_aiAgent_documents_on_topic_id_and_external_link', unique: true
    add_index :aiAgent_documents, :status, name: 'index_aiAgent_documents_on_status'

    add_index :aiAgent_topic_responses, :account_id, name: 'index_aiAgent_topic_responses_on_account_id'
    add_index :aiAgent_topic_responses, :topic_id, name: 'index_aiAgent_topic_responses_on_topic_id'
    add_index :aiAgent_topic_responses, :status, name: 'index_aiAgent_topic_responses_on_status'
    add_index :aiAgent_topic_responses, [:documentable_type, :documentable_id], name: 'idx_cap_asst_resp_on_documentable'
    execute 'CREATE INDEX vector_idx_knowledge_entries_embedding ON aiAgent_topic_responses USING ivfflat (embedding vector_cosine_ops)'

    add_index :aiAgent_topics, :account_id, name: 'index_aiAgent_topics_on_account_id'
  end
end
