# typed: false

if Rails.env.production?
  class << Rails.application
    def allow_invitation_requests?
      ENV["ALLOW_INVITATION_REQUESTS"] == "true"
    end

    def allow_new_users_to_invite?
      ENV.fetch("ALLOW_NEW_USERS_TO_INVITE", "true") == "true"
    end

    def domain
      ENV.fetch("SITE_DOMAIN", "dst.imim.im")
    end

    def name
      ENV.fetch("SITE_NAME", "Distort")
    end

    def og_description
      ENV.fetch("SITE_DESCRIPTION", "A small link aggregation and discussion community.")
    end
  end
end
