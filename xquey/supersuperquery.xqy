xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.paises.org";
(:: import schema at "../xsd/paises.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/dbReferenceListapaises";
(:: import schema at "../Resources/dbReferenceListapaises.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/top/dbReferencePersonas";
(:: import schema at "../Resources/dbReferencePersonas_table.xsd" ::)

declare variable $entrada1 as element() (:: schema-element(ns1:dbReferenceListapaisesOutputCollection) ::) external;
declare variable $entrada2 as element() (:: schema-element(ns2:PersonasCollection) ::) external;
declare variable $entrada3 as element() (:: schema-element(ns3:Paises) ::) external;

declare function local:func($entrada1 as element() (:: schema-element(ns1:dbReferenceListapaisesOutputCollection) ::), 
                            $entrada2 as element() (:: schema-element(ns2:PersonasCollection) ::), 
                            $entrada3 as element() (:: schema-element(ns3:Paises) ::)) 
                            as element() (:: schema-element(ns3:salida) ::) {
    <ns3:salida>
        <ns3:ListadePaises>
            {
                for $Pais in $entrada3/ns3:Pais
                return
                for $dbReferenceListapaisesOutput in $entrada1/ns1:dbReferenceListapaisesOutput
                return 
                if (fn:data(fn:upper-case($Pais/ns3:nombre)) = fn:data($dbReferenceListapaisesOutput/ns1:ID_PAIS)) then
                (<ns3:Pais>
                    <ns3:nombrepais>{fn:data($dbReferenceListapaisesOutput/ns1:ID_PAIS)}</ns3:nombrepais>
                    <ns3:descripcion>{fn:data($dbReferenceListapaisesOutput/ns1:DESCRIPCION)}</ns3:descripcion>
                    
                 
                    <ns3:ListadePersonas>
                        {
                            for $Personas in $entrada2/ns2:Personas
                            return 
                            if (fn:data($dbReferenceListapaisesOutput/ns1:ID_PAIS) = fn:data($Personas/ns2:pais)) then
                (
                            
                             <ns3:Persona>
                                <ns3:dni>{fn:data($Personas/ns2:dni)}</ns3:dni>
                                <ns3:apellido>{fn:data($Personas/ns2:nombre)}</ns3:apellido>
                                <ns3:nombre>{fn:data($Personas/ns2:apellido)}</ns3:nombre></ns3:Persona>)
                                else
                                ()
                        }
                    </ns3:ListadePersonas></ns3:Pais>)
                else
                ()
            
                
            }
           
                  </ns3:ListadePaises>
    </ns3:salida>
};

local:func($entrada1, $entrada2, $entrada3)
