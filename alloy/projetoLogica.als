module fidelizacao

-- classe fidelizacao que tem como atributo o tipo de fidelizacao, que varia com o percentual de boletos pagos
sig Fidelizacao{
	tipoFidelizacao: one(TipoFidelizacao)
}

-- classe cliente que tem como atributo boletos
sig Cliente{
	boletos: set(Boleto)	
}

-- classe boleto que tem como atributos a data de vencimento em string e se o boleto ja foi pago(1 ou 0)
sig Boleto{
	vencimento:String,
	pago:Int
}

-- classe abstrata dos tipos de fidelizacao
abstract sig TipoFidelizacao{}

--os tipos de fidelizacao, que extendem a classe TipoFidelização
sig Ouro, Prata, Bronze extends TipoFidelizacao{}

-- classe socio faz a juncao de fidelizacao e cliente, os tendo como atributo
sig Socio{
	cliente: one(Cliente),
	fidelizacao: one(Fidelizacao)
}

pred show[]{}
run show for 6
 
