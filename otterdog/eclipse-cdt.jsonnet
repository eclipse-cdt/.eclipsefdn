local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local custom_branch_protection_rule(pattern) = 
  orgs.newBranchProtectionRule(pattern) {
    required_approving_review_count: 0,
  };

orgs.newOrg('tools.cdt', 'eclipse-cdt') {
  settings+: {
    description: "",
    name: "Eclipse CDT™ (C/C++ Development Tooling)",
    web_commit_signoff_required: false,
    workflows+: {
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/cdt/github-webhook/') {
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  secrets+: [
    orgs.newOrgSecret('GITLAB_API_TOKEN') {
      value: "pass:bots/tools.cdt/gitlab.eclipse.org/api-token",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "Eclipse CDT™ C/C++ Development Tools",
      has_issues: false,
      has_wiki: false,
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
      ],
    },
    orgs.newRepo('cdt') {
      allow_auto_merge: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse CDT™ C/C++ Development Tools",
      has_discussions: true,
      has_wiki: false,
      homepage: "http://eclipse.org/cdt",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
        custom_branch_protection_rule('org.eclipse.remote-master'),
        custom_branch_protection_rule('cdt_*'),
      ],
    },
    orgs.newRepo('cdt-infra') {
      archived: true,
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      has_wiki: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
    orgs.newRepo('cdt-lsp') {
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Eclipse CDT™ LSP Extensions for CDT",
      has_discussions: true,
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
        custom_branch_protection_rule('cdt_lsp_*'),
      ],
    },
    orgs.newRepo('cdt-new-managedbuild-prototype') {
      archived: true,
      default_branch: "master",
      description: "Prototype of new Managed Build system for Eclipse CDT",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
    orgs.newRepo('cdt-vscode') {
      archived: true,
      default_branch: "master",
      description: "C/C++ Development Tooling (CDT) Visual Studio Code extension",
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
  ],
}
