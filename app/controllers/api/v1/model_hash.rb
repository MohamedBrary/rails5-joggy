module Api::V1::ModelHash
  
  def user_hash(user)
    {
        id: user.id,
        email: user.email,
        name: user.name
    }
  end

  def user_token_hash(user_token, *args)
    options = args.extract_options!
    output = {
        access_token: user_token.access_token
    }
    output.update(user: user_hash(user_token.user)) if true == options[:user]
    output
  end

  def run_hash(run)
    {
        id: run.id,
        date: run.date,
        avg_speed: run.avg_speed,
        distance: run.distance,
        duration: run.duration_minutes,
        user_id: run.user_id,
        user: run.user.name
    }
  end
  
  def runs_hash(runs)
    runs.map{|r| run_hash(r)}
  end
end
