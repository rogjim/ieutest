<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DescripcionAsignacion</fullName>
        <description>Descripcion de asignacion</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Prospectos/PlantillaPromotorAsignado</template>
    </alerts>
    <alerts>
        <fullName>DescripcionAsignacionW2L</fullName>
        <description>Descripcion de asignacion W2L</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Prospectos/PlantillaPromotorAsignado</template>
    </alerts>
    <alerts>
        <fullName>DescripcionAsignacionW2L2</fullName>
        <description>Descripcion de asignacion W2L</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Prospectos/PlantillaPromotorAsignado</template>
    </alerts>
    <alerts>
        <fullName>Prueba</fullName>
        <description>Prueba</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>sf4twitter__Salesforce_for_Social_Media/sf4twitter__Default_Template</template>
    </alerts>
    <alerts>
        <fullName>Se_envia_correo_electronico_del_calculo</fullName>
        <description>Se envia correo electronico del calculo</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Prospectos/CorreoCalculadora</template>
    </alerts>
    <fieldUpdates>
        <fullName>ActivarAsignacionW2L</fullName>
        <field>ActivarAsignacionW2L__c</field>
        <literalValue>1</literalValue>
        <name>Activar Asignacion W2L</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ActualizarEnviarAlertaW2L</fullName>
        <field>EnviarAlertaW2L__c</field>
        <literalValue>1</literalValue>
        <name>Actualizar Enviar Alerta W2L</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BecaInicial</fullName>
        <field>BecaInicial__c</field>
        <formula>PorcentajeBeca__c</formula>
        <name>Beca inicial</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BorraCompaniaLead</fullName>
        <field>Company</field>
        <name>Borra compañia en lead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CopiaEstado</fullName>
        <field>EstadoOtro__c</field>
        <formula>Estado__r.Name</formula>
        <name>Copia estado</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CopiarEstado</fullName>
        <field>EstadoOtro__c</field>
        <formula>IF( ISNULL(EstadoOtro__c) ,  Estado__r.Name , EstadoOtro__c)</formula>
        <name>Copiar estado</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DescuentoInicial</fullName>
        <field>DescuentoInicial__c</field>
        <formula>PorcentajeDescuento__c</formula>
        <name>Descuento inicial</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Activar asignacion W2L</fullName>
        <actions>
            <name>ActivarAsignacionW2L</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Sobre escribe la asignación del propietario de los candidatos provenientes de los formatos WebToLead. Al actualizar el campo se ejecuta el trigger sobre Candidato que proporciona la asignación del candidato</description>
        <formula>ISPICKVAL(LeadSource, &apos;Marketing&apos;) &amp;&amp; ISPICKVAL(SubOrigenCandidato__c ,&apos;Verticales IEU (por programa)&apos;) &amp;&amp; WebToLead__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Asignación de promotor</fullName>
        <actions>
            <name>DescripcionAsignacion</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Solo aplica para LP</description>
        <formula>AsignacionAutomatica__c &amp;&amp; NOT(ISBLANK(Promotor__c)) &amp;&amp;  TEXT(SubOrigenCandidato__c)  &lt;&gt; &apos;Calcula tu colegiatura&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Borra compañia en lead</fullName>
        <actions>
            <name>BorraCompaniaLead</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Copia estado Candidato</fullName>
        <actions>
            <name>CopiaEstado</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF(Pais__r.Name = &quot;MEXICO&quot;, True, False)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Correo Calculadora</fullName>
        <actions>
            <name>Se_envia_correo_electronico_del_calculo</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Marketing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.SubOrigenCandidato__c</field>
            <operation>equals</operation>
            <value>Calcula tu colegiatura</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Creacion Ficha Pago</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Marketing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.SubOrigenCandidato__c</field>
            <operation>equals</operation>
            <value>Preinscripción</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Descuento y beca inicial</fullName>
        <actions>
            <name>BecaInicial</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>DescuentoInicial</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Marketing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.SubOrigenCandidato__c</field>
            <operation>equals</operation>
            <value>Calcula tu colegiatura,Preinscripción</value>
        </criteriaItems>
        <description>Mapea el descuento y beca que obtiene al registrar de LP</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Enviar Alerta W2L</fullName>
        <actions>
            <name>DescripcionAsignacionW2L2</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.ActivarAsignacionW2L__c</field>
            <operation>equals</operation>
            <value>Verdadero</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.SeAsignoPromotor__c</field>
            <operation>equals</operation>
            <value>Verdadero</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
