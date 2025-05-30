import ApiClient from '../ApiClient';

class AiAgentBulkActionsAPI extends ApiClient {
  constructor() {
    super('aiAgent/bulk_actions', { accountScoped: true });
  }
}

export default new AiAgentBulkActionsAPI();
