local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local custom_branch_protection_rule(pattern) = 
  orgs.newBranchProtectionRule(pattern) {
    required_approving_review_count: 0,
  };

orgs.newOrg('eclipse-cdt') {
  settings+: {
    billing_email: "webmaster@eclipse.org",
    default_repository_permission: "none",
    dependabot_alerts_enabled_for_new_repositories: false,
    dependabot_security_updates_enabled_for_new_repositories: false,
    dependency_graph_enabled_for_new_repositories: false,
    description: "",
    name: "Eclipse CDT™ (C/C++ Development Tooling)",
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    security_managers+: [
      "tools-cdt-committers"
    ],
    two_factor_requirement: false,
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
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_update_branch: false,
      dependabot_alerts_enabled: false,
      description: "Eclipse CDT™ C/C++ Development Tools",
      has_issues: false,
      has_wiki: false,
      homepage: "",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        custom_branch_protection_rule('main'),
      ],
    },
    orgs.newRepo('cdt') {
      allow_auto_merge: true,
      allow_merge_commit: false,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse CDT™ C/C++ Development Tools",
      has_discussions: true,
      has_wiki: false,
      homepage: "http://eclipse.org/cdt",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
    orgs.newRepo('cdt-infra') {
      allow_update_branch: false,
      default_branch: "master",
      dependabot_security_updates_enabled: true,
      has_wiki: false,
      web_commit_signoff_required: false,
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
    orgs.newRepo('cdt-lsp') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      description: "Eclipse CDT™ LSP Extensions for CDT",
      has_discussions: true,
      web_commit_signoff_required: false,
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
    orgs.newRepo('cdt-new-managedbuild-prototype') {
      archived: true,
      default_branch: "master",
      description: "Prototype of new Managed Build system for Eclipse CDT",
      web_commit_signoff_required: false,
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
      branch_protection_rules: [
        custom_branch_protection_rule('*'),
      ],
    },
  ],
}
