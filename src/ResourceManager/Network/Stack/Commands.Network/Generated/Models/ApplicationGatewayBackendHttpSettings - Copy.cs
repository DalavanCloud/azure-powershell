// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
// 
// Code generated by Microsoft (R) AutoRest Code Generator 0.12.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.

namespace Microsoft.Azure.Management.Network.Models
{
    using System;
    using System.Linq;
    using System.Collections.Generic;
    using Newtonsoft.Json;
    using Microsoft.Rest;
    using Microsoft.Rest.Serialization;
    using Microsoft.Rest.Azure;

    /// <summary>
    /// Backend address pool settings of application gateway
    /// </summary>
    public partial class ApplicationGatewayBackendHttpSettings : SubResource
    {
        /// <summary>
        /// Initializes a new instance of the
        /// ApplicationGatewayBackendHttpSettings class.
        /// </summary>
        public ApplicationGatewayBackendHttpSettings() { }

        /// <summary>
        /// Initializes a new instance of the
        /// ApplicationGatewayBackendHttpSettings class.
        /// </summary>
        public ApplicationGatewayBackendHttpSettings(string name = default(string), string etag = default(string), int? port = default(int?), string protocol = default(string), string cookieBasedAffinity = default(string), string provisioningState = default(string))
        {
            Name = name;
            Etag = etag;
            Port = port;
            Protocol = protocol;
            CookieBasedAffinity = cookieBasedAffinity;
            ProvisioningState = provisioningState;
        }

        /// <summary>
        /// Gets name of the resource that is unique within a resource group.
        /// This name can be used to access the resource
        /// </summary>
        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }

        /// <summary>
        /// A unique read-only string that changes whenever the resource is
        /// updated
        /// </summary>
        [JsonProperty(PropertyName = "etag")]
        public string Etag { get; set; }

        /// <summary>
        /// Gets or sets the port
        /// </summary>
        [JsonProperty(PropertyName = "properties.port")]
        public int? Port { get; set; }

        /// <summary>
        /// Gets or sets the protocol. Possible values for this property
        /// include: 'Http', 'Https'.
        /// </summary>
        [JsonProperty(PropertyName = "properties.protocol")]
        public string Protocol { get; set; }

        /// <summary>
        /// Gets or sets the cookie affinity. Possible values for this
        /// property include: 'Enabled', 'Disabled'.
        /// </summary>
        [JsonProperty(PropertyName = "properties.cookieBasedAffinity")]
        public string CookieBasedAffinity { get; set; }

        /// <summary>
        /// Gets or sets Provisioning state of the backend http settings
        /// resource Updating/Deleting/Failed
        /// </summary>
        [JsonProperty(PropertyName = "properties.provisioningState")]
        public string ProvisioningState { get; set; }

    }
}