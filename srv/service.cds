using { apihub_sandbox } from './external/apihub_sandbox.cds';

using { RiskManagement as my } from '../db/schema.cds';

@path : '/service/RiskManagementService'
service RiskManagementService
{
    @cds.redirection.target
    @odata.draft.enabled
    entity Risks as
        projection on my.Risks;

    @cds.redirection.target
    @odata.draft.enabled
    entity Mitigations as
        projection on my.Mitigations;

    @cds.redirection.target
    entity A_BusinessPartner as
        projection on apihub_sandbox.A_BusinessPartner
        {
            BusinessPartner,
            Customer,
            Supplier,
            BusinessPartnerCategory,
            BusinessPartnerFullName,
            BusinessPartnerIsBlocked
        };
}

annotate RiskManagementService with @requires :
[
    'authenticated-user'
];

annotate RiskManagementService.Risks with @Restrict: [
    { grant: 'READ', to: 'RiskViewer' },
    { grant: ['CREATE', 'READ', 'UPDATE', 'DELETE', 'WRITE'], to: 'RiskManager' }
];

annotate RiskManagementService.Mitigations with @Restrict: [
    { grant: 'READ', to: 'RiskViewer' },
    { grant: ['CREATE', 'READ', 'UPDATE', 'DELETE', 'WRITE'], to: 'RiskManager' }
]