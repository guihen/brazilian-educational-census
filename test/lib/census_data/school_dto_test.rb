require "test_helper"
require Rails.root.join("lib", "census_data", "school_dto")
require 'csv'

class SchoolDtoTest < ActiveSupport::TestCase
  SAMPLE_1 = "2021;Norte;1;Rondônia;RO;11;Alta Floresta D'Oeste;1100015;Leste Rondoniense;1102;Cacoal;11006;110001505;11024275;CEEJA LUIZ VAZ DE CAMOES;2;;1;0;AVENIDA RIO DE JANEIRO;4776;ESCOLA;CIDADE ALTA;76954000;69;36412656;1;00015;22FEB2021:00:00:00;21DEC2021:00:00:00;1;0;0;0;;;;;;;;;;;;1;2;;;1;1;;0;1;1;;;0;;0;0;0;;1;1;0;0;0;0;1;;0;;0;0;0;1;0;1;0;1;0;0;0;0;;;;0;0;0;1;0;0;0;;;1;0;1;1;1;;1;1;1;1;0;0;1;1;1;0;0;0;1;1;0;1;0;0;0;0;1;1;1;0;1;0;0;0;;;0;1;0;0;1;0;0;1;1;0;;10;1;11;10;8;1;1;0;1;1;0;0;1;1;1;5;1;1;0;0;1;4;;;;;;;;;;;;;;1;8;1;4;0;0;;;1;1;1;1;0;1;0;1;1;;1;3;1;6;1;2;0;0;0;0;0;0;0;0;0;0;1;3;1;7;1;1;0;0;1;1;1;1;0;0;1;0;1;0;0;0;0;0;0;0;0;0;1;1;1;0;0;0;0;;;;0;;;;;;;0;;;;;;;1;1;0;0;0;1;0;0;0;1;0;0;1;1;0;0;1;1;1;1;0;0;0;0;0;0;0;0;0;1;1;1;1;1;0;231;0;0;0;0;0;0;0;0;0;231;96;135;5;5;0;128;103;2;62;6;153;0;8;0;0;0;0;15;216;7;204;20;0;0;0;0;0;0;0;14;0;0;0;0;0;0;0;0;0;14;13;10;12;12;0;11;0;0;0;0;0;0;0;0;0;11;7;4;5;5;0".freeze

  SAMPLE_2 = "2021;Nordeste;2;Pernambuco;PE;26;São Caitano;2613107;Agreste Pernambucano;2603;Vale do Ipojuca;26008;261310705;26062836;ESCOLA DE REFERENCIA EM ENSINO FUNDAMENTAL E MEDIO JOAQUIM RIBEIRO DA ROCHA;2;;1;0;RUA RODOLFO TORRES;SN;;CABUGA;55130000;81;37361758;1;00009;03FEB2021:00:00:00;21DEC2021:00:00:00;1;0;0;0;;;;;;;;;;;;1;2;;;1;1;;0;0;0;;;0;;0;0;0;;1;1;0;0;0;0;1;;0;;0;0;0;1;0;1;0;1;0;0;0;0;;;;0;0;0;1;0;0;0;;;1;0;1;1;0;;1;1;1;1;0;0;0;0;0;1;0;0;0;0;0;1;0;0;0;0;1;0;1;0;1;1;0;0;;;0;1;0;0;1;1;0;0;0;0;;9;0;9;0;9;0;1;0;1;1;0;0;0;0;0;0;0;0;0;0;1;3;;;;;;;;;;;;;;1;10;0;0;1;26;;;1;1;1;1;0;1;0;2;1;;1;1;1;2;0;0;0;0;0;0;0;0;0;0;0;0;1;4;1;1;1;1;0;0;0;0;1;1;0;0;1;1;0;0;0;0;0;0;0;0;1;0;1;0;0;0;0;0;0;;;;0;;;;;;;0;;;;;;;1;0;0;0;0;1;0;1;0;1;0;0;1;0;0;1;1;1;0;1;0;0;0;1;0;1;1;0;0;1;1;0;1;1;0;296;0;0;0;163;0;163;84;0;0;49;49;0;12;12;0;171;125;242;20;2;31;0;1;0;0;3;131;100;62;228;68;0;0;0;0;39;0;39;0;1;1;0;1;1;1;0;0;0;0;0;0;0;1;1;0;11;0;0;0;6;0;6;3;0;0;2;2;0;7;7;0".freeze

  SAMPLE_WITHOUT_ZIPCODE = "2022;Norte;1;Amazonas;AM;13;Anori;1300102;Centro Amazonense;3;Coari;6;130010205;ESC NOVA ESPERANCA;13014960;3;;2;;LIBERDADE I;;;;;.;.;3;0MI36;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"

  test "should initializes receiving a line from the census file" do
    assert_nothing_raised do
      SchoolDto.new(SAMPLE_1)
    end
  end

  test "should returns the school name for the SAMPLE_1" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.name, "CEEJA LUIZ VAZ DE CAMOES"
  end

  test "should returns the school name for the SAMPLE_2" do
    school_dto = SchoolDto.new(SAMPLE_2)

    assert_equal school_dto.name, "ESCOLA DE REFERENCIA EM ENSINO FUNDAMENTAL E MEDIO JOAQUIM RIBEIRO DA ROCHA"
  end

  test "should returns the school region" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.region, "Norte"
  end

  test "should returns the school state" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.state, "Rondônia"
  end

  test "should returns the scholl conty" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.county, "Alta Floresta D'Oeste"
  end

  test "should returns the school zipcode" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.zipcode, "76954000"
  end

  test "should returns '00000000' if the school doens't have a zipcode" do 
    school_dto = SchoolDto.new(SAMPLE_WITHOUT_ZIPCODE)

    assert_equal school_dto.zipcode, "00000000"
  end

  test "should receives the line parser as an optional parameter in the initializer" do
    expected_interface = CSV
    assert_nothing_raised do
      SchoolDto.new(SAMPLE_1, CSV)
    end
  end

  test "should returns the school code" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.code, "11024275"
  end

  test "should returns the school racial diversity" do
    school_dto = SchoolDto.new(SAMPLE_1)
    expected_diversity = {
        nao_declarado: 2,
        branca: 62,
        preta: 6,
        parda: 153,
        amarela: 0,
        indigena: 8
    }

    assert_equal school_dto.racial_diversity, expected_diversity
  end

  test "should returns the year of the census" do
    school_dto = SchoolDto.new(SAMPLE_1)

    assert_equal school_dto.census_year, 2021
  end
end
