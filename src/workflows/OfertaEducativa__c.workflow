<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NotificarNuevaOE</fullName>
        <description>Notificar al VR de la nueva OE</description>
        <protected>false</protected>
        <recipients>
            <recipient>VicerrectorMarketing</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/NuevaOE</template>
    </alerts>
    <fieldUpdates>
        <fullName>BecaConfigurada</fullName>
        <field>BecaConfiguarada__c</field>
        <literalValue>1</literalValue>
        <name>Beca configurada</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EnvioAlerta</fullName>
        <description>Indica que se envía alerta para notificar al Vicerrector</description>
        <field>EnvioAlerta__c</field>
        <literalValue>1</literalValue>
        <name>EnvioAlerta</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AutorizarOE</fullName>
        <actions>
            <name>NotificarNuevaOE</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>EnvioAlerta</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>OfertaEducativa__c.GrupoConfigurado__c</field>
            <operation>equals</operation>
            <value>Verdadero</value>
        </criteriaItems>
        <criteriaItems>
            <field>OfertaEducativa__c.PagoConfigurado__c</field>
            <operation>equals</operation>
            <value>Verdadero</value>
        </criteriaItems>
        <criteriaItems>
            <field>OfertaEducativa__c.BecaConfiguarada__c</field>
            <operation>equals</operation>
            <value>Verdadero</value>
        </criteriaItems>
        <criteriaItems>
            <field>OfertaEducativa__c.EnvioAlerta__c</field>
            <operation>equals</operation>
            <value>Falso</value>
        </criteriaItems>
        <description>Notifica al perfil de vicerrector para que autorice un grupo</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Beca configurada</fullName>
        <actions>
            <name>BecaConfigurada</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Actualiza el estatus de beca configurada de una OE</description>
        <formula>NOT(ISBLANK(Beca__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
