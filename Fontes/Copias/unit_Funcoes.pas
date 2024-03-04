unit unit_Funcoes;

interface

        function frc_criar_msg (TituloJanela, TutuloMSG, MSG, Icone, Tipo : String): Boolean;
        function fncRemoveCaracteres(AString: String) : String;
        function fnc_Criptografia(Senha, Chave: string) : string;
        Function fnc_FormataValor(Valor : string): string;

implementation
      uses unit_Menssagens, System.SysUtils;

      function frc_criar_msg (TituloJanela, TutuloMSG, MSG, Icone, Tipo : String): Boolean;
        begin
          result := false;

          form_Menssagens := Tform_Menssagens.Create( nil );
          form_Menssagens.sTituloJanela := TituloJanela;
          form_Menssagens.sTituloMsg    := TutuloMSG;
          form_Menssagens.sMsg          := MSG;
          form_Menssagens.sCaminhoImg   := Icone;
          form_Menssagens.sTipo         := Tipo;

          form_Menssagens.ShowModal;
          Result := form_Menssagens.bRespostaMSG;
        end;

      function fncRemoveCaracteres(AString: String) : String;
      var
	      i : integer;
	      sts_Limpos : String;
      begin

	      sts_Limpos := '';
	      for i := 1 to Length(AString) do
	        begin
	            if Pos ( Copy  (AString, i, 1), '"!%$#@&¨*().,;:/<>[]{}=+-_\|') = 0 then
		            sts_Limpos := sts_Limpos + Copy(AString, i, 1);
	        end;
	      Result := sts_Limpos;
      end;

      function fnc_Criptografia(Senha, Chave: string) : string;
      var
 	      x, y : integer;
	      str_NovaSenha : string;
      begin
	      for x := 1 to Length ( Chave) do
      	begin
		      str_NovaSenha := '';
		      for y := 1 to Length ( Senha) do
	      	begin
			      str_NovaSenha := str_NovaSenha + chr(( Ord( Chave[x] ) xor Ord(Senha[y])));
		      end;
		      Senha := str_NovaSenha;
	      end;
	      result := Senha;
      end;

Function fnc_FormataValor(Valor : string): string;
  begin

    // Primeiro, remove os pontos do valor
    Valor := StringReplace(Valor, '.', '', [rfReplaceAll, rfIgnoreCase]);

    // Segundo, troca a vírgula pelo ponto (casa decimal)
    Valor := StringReplace(Valor, ',', '.', [rfReplaceAll, rfIgnoreCase]);

    // O valor será formatado sem pontos de milhares e com ponto como separador decimal
    Result := Valor;
  end;

end.
