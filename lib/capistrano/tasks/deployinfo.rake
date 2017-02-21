namespace :deploy do
  task :write_info do
    on roles(fetch(:deployinfo_roles)) do
      run_locally do
        tags = capture("git tag |sort -n")
        git_tag = tags.split("\n").last
        commits_since = capture("git rev-list `git rev-list --tags --no-walk --max-count=1`..HEAD --count")
        if commits_since == 0
          set :app_tag, fetch(:git_tag)
        else
          set :app_tag, "#{commits_since}-ahead-of-#{git_tag}"
        end
      end
      within fetch(:deployinfo_path) do
        rev = fetch(:current_revision).to_s
        tag = { app: fetch(:application),
                tag: fetch(:app_tag),
                deployed_at: Time.now.strftime("%a %b %d %Y, %H:%M:%S"),
                unix_time: Time.now.to_i,
                branch: fetch(:branch),
                user: local_user.strip,
                full_sha: rev,
                release: release_timestamp,
                sha: rev[0..6]
        }

        tag_path = current_path.join(fetch(:deployinfo_dir), fetch(:deployinfo_filename))

        execute %{echo '#{tag.to_json}' > #{tag_path}}
      end
    end
  end

  after 'deploy:published', 'deploy:write_info'
end

namespace :load do
  task :defaults do
    set :deployinfo_roles, :all
    set :deployinfo_dir, 'public'
    set :deployinfo_filename, 'deploy.json'
  end
end
