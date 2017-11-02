// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.

namespace Microsoft.Azure.Commands.Relay.Models
{
    using Rest.Serialization;
    using System.Collections.Generic;
    using Azure.Management.Relay.Models;

    /// <summary>
    /// Description of a Namespace AuthorizationRules.
    /// </summary>
    public partial class AuthorizationRuleAttributes
    {
        /// <summary>
        /// 
        /// </summary>
        public const string DefaultClaimType = "SharedAccessKey";
        /// <summary>
        /// 
        /// </summary>
        public const string DefaultClaimValue = "None";

        /// <summary>
        /// 
        /// </summary>
        internal const string DefaultNamespaceAuthorizationRule = "RootManageSharedAccessKey";

        /// <summary>
        /// Initializes a new instance of the AuthorizationRule class.
        /// </summary>
        public AuthorizationRuleAttributes() { Rights = new List<string>(); }

        /// <summary>
        /// Initializes a new instance of the AuthorizationRule class.
        /// </summary>
        /// <param name="rights">The rights associated with the rule.</param>
        /// <param name="id">Resource Id</param>
        /// <param name="name">Resource name</param>
        /// <param name="type">Resource type</param>
        
        public AuthorizationRuleAttributes(AuthorizationRule authorizationrule)
        {
            Id = authorizationrule.Id;
            Name = authorizationrule.Name;
            Type = authorizationrule.Type;

            Rights = new List<string>();

            foreach (AccessRights rights in authorizationrule.Rights)
            {
                Rights.Add(rights.ToString());
            }            
        }


        /// <summary>
        /// Gets or sets the rights associated with the rule.
        /// </summary>
        public IList<string> Rights { get; set; }

        /// <summary>
        /// Gets or sets the rights associated with the rule.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the rights associated with the rule.
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// Gets or sets the rights associated with the rule.
        /// </summary>
        public string Id { get; set; }

    }
}
