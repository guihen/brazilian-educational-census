class GroupBySetor
  def initialize(schools)
    @schools = schools
    @memo = {}
    @result = []
  end

  def call
    initialize!

    @schools.each_with_object(@memo) do |school, memo|
      memo[school.setor] << school
    end

    @memo.each do |setor, schools|
      SetorGroup.new.tap do |setor_group|
        setor_group.setor = setor
        setor_group.racial_diversity = SumRacialDiversity.new(schools.map(&:racial_diversity)).call
        @result << setor_group
      end
    end

    @result
  end

  private

  def initialize!
    setores = @schools.map { |school| school.setor }.uniq
    setores.each_with_object(@memo) do |setor, memo|
      memo[setor] = []
    end
  end
end
