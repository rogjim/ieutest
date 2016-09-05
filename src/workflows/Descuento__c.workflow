<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AutorizarPromcion</fullName>
        <description>Autorizar promoción</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorFinanzas</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Autorizaciones/AutorizarPomociones</template>
    </alerts>
    <alerts>
        <fullName>PromocionAutorizada</fullName>
        <description>Promoción autorizada</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Autorizaciones/PromocionAutorizada</template>
    </alerts>
    <alerts>
        <fullName>RechazaPromocion</fullName>
        <description>Rechaza promoción</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Autorizaciones/PromocionRechazada</template>
    </alerts>
    <fieldUpdates>
        <fullName>ActualizaAutorizadoDescuento</fullName>
        <field>Estatus__c</field>
        <literalValue>Activo</literalValue>
        <name>Actualiza a Autorizado-Descuento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ActualizaRechazadoDescuento</fullName>
        <field>Estatus__c</field>
        <literalValue>Rechazado</literalValue>
        <name>Actualiza a Rechazado Descuento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Autoriza_promociones</fullName>
        <field>OwnerId</field>
        <lookupValue>AutorizaDescuentos</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Autoriza promociones</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Solicitud de promoción</fullName>
        <actions>
            <name>AutorizarPromcion</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Autoriza_promociones</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Descuento__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Promoción Solicitada</value>
        </criteriaItems>
        <description>Cada que se genera un tipo de descuento tipo &quot;solicitud de promoción&quot; se tiene que autorizar.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
