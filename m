Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C325A321;
	Tue,  7 Apr 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587787; cv=none; b=cgqpbsGKfYAO1ZTXNvEPM9uYZKsVDyMCsTZt4aNQq8bfCyFez8WTo5o5FHjgRu+qbxos32AmuW2vVUrkoIQX/iO14Opbo2EYp0xsT8eHt4vmCLDBjevYSHjOe4s9zETMhthpRIqQJodMhfHzFxIwz2YCotanVTO8vfZ/h/QinFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587787; c=relaxed/simple;
	bh=Ww/tGoOCGMXlpoAhTErJUastEAt/qAbFxFbUshvlUrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNYa02u1K02SBEkCGs8iV6Qw6f550hBTcHqA3BsOjIDlaXjwMF5o6YCRKCEuuA8EymqN7ZPXtjUWITZMfNTce+G7FjyIZiOiWgZ8t1XzC9UtRbt+L4Orksz9sptJqaIWsOnh9cVToLulOTehWYeNbnPfYs6x3WH8y/JAOrmw7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfo2l+kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfo2l+kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E57C116C6;
	Tue,  7 Apr 2026 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775587786;
	bh=Ww/tGoOCGMXlpoAhTErJUastEAt/qAbFxFbUshvlUrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mfo2l+klcoC3PTyb1HByIhNQzzMrxmQ6BBXhKfolMs4IEe5oSzrgniU4rNT9qdyDp
	 /KpU78THVLBSAiKVnzqaO2MrrZh96ELu1OFO+urXJi+g2rM1ysFNu+gXXUvilOQAFq
	 yZh7CtEwcPTeeh/pimEpODU0H0fBQIduEWxWqkSA1Iq8JBfVszrd/lFEI0Cl/0O+9s
	 dY2a/hDKDg9g8o67w9ViS2Pon6TWg/AowSH/pTDw6m4YRlbqZs4Ix1RoLgRYdL1npp
	 +7dKOD0NvZi4CZxG/1pZoSoHVlqAHG7b/Rx1xc8oW6LgvXptJ3DYdMuYb7Hlg82yPl
	 tRMDKf0K9xTVw==
Date: Tue, 7 Apr 2026 13:49:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
	heiko@sntech.de, krzk+dt@kernel.org, marex@nabladev.com,
	dev@kael-k.io, linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org, yilun.xu@intel.com, mdf@kernel.org,
	trix@redhat.com
Subject: Re: [PATCH v6 2/3] dt-bindings: fpga: Add Efinix SPI programming
 bindings
Message-ID: <177558778432.3381193.260526814795485933.robh@kernel.org>
References: <20260327114842.1300284-1-iansdannapel@gmail.com>
 <20260327114842.1300284-3-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327114842.1300284-3-iansdannapel@gmail.com>


On Fri, 27 Mar 2026 12:48:40 +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add device tree bindings documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  .../bindings/fpga/efinix,trion-config.yaml    | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-config.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

