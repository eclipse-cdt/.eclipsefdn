local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-cdt') {
  settings+: {
    billing_email: "webmaster@eclipse.org",
    default_repository_permission: "none",
    default_workflow_permissions: "write",
    dependabot_alerts_enabled_for_new_repositories: false,
    dependabot_security_updates_enabled_for_new_repositories: false,
    dependency_graph_enabled_for_new_repositories: false,
    description: "",
    members_can_change_repo_visibility: true,
    members_can_delete_repositories: true,
    name: "Eclipse CDT\u2122 (C/C++ Development Tooling)",
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    two_factor_requirement: false,
    web_commit_signoff_required: false,
  },
  webhooks+: [
    orgs.newWebhook() {
      events+: [
        "pull_request",
        "push"
      ],
      url: "https://ci.eclipse.org/cdt/github-webhook/",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_update_branch: false,
      dependabot_alerts_enabled: false,
      description: "Eclipse CDT\u2122 C/C++ Development Tools",
      has_issues: false,
      has_wiki: false,
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('cdt') {
      allow_auto_merge: true,
      allow_merge_commit: false,
      allow_update_branch: false,
      description: "Eclipse CDT\u2122 C/C++ Development Tools",
      has_wiki: false,
      homepage: "http://eclipse.org/cdt",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('*') {
          bypass_pull_request_allowances+: [
            "@jonahgraham"
          ],
          required_approving_review_count: 0,
          required_status_checks+: [],
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('cdt-infra') {
      allow_update_branch: false,
      default_branch: "master",
      has_wiki: false,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          required_status_checks+: [],
          requires_approving_reviews: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('cdt-lsp') {
      allow_merge_commit: false,
      allow_update_branch: false,
      default_branch: "master",
      description: "Eclipse CDT\u2122 LSP Extensions for CDT",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('cdt-new-managedbuild-prototype') {
      archived: true,
      default_branch: "master",
      description: "Prototype of new Managed Build system for Eclipse CDT",
      secret_scanning: "disabled",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          required_status_checks+: [],
          requires_approving_reviews: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('cdt-vscode') {
      archived: true,
      default_branch: "master",
      description: "C/C++ Development Tooling (CDT) Visual Studio Code extension",
      homepage: "",
      secret_scanning: "disabled",
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          required_status_checks+: [],
          requires_approving_reviews: false,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
  ],
}
