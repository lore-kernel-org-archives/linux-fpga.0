Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE7B34E74F;
	Wed, 19 Nov 2025 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584435; cv=none; b=Rd/z0UIA7+SHO5/lzamu2/t01ITLKPJlP50uo5hj+m4F7bdRHzxRO77GTVXSMw2Rhs5pBxvSyqmjr8BSB4dBhZQnHoDM6eDl3mzImAeTKsojAo0aROqRJGUbeZMSjS5+xbLJBxpTe7r1/VfhNOyOyVsLW4KiIG03G7kudQ3nxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584435; c=relaxed/simple;
	bh=7MC246WAT4qGtEp1Vgb4baQGVYIvRpxxnxb3X6u/QcI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EZg219uDSK3W7D2jmEh19dM4WrXHt1DfuigpqCpNPwd9C8BCYSR8xXr5a4rl4lMUU6vzsuwlo/LOPxWbTuTPZ+H8zx/6nSb/vABIWAgrZdgvZhth6JhGayA9glx+ut1z96bWL5EYS3sVCtgKI0AcksZy1H9vMNYpVY8oO6H/JMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEZjtwvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEZjtwvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C05C4CEF5;
	Wed, 19 Nov 2025 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763584434;
	bh=7MC246WAT4qGtEp1Vgb4baQGVYIvRpxxnxb3X6u/QcI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YEZjtwvh6II2fyW2gAKfUu9f6uo1Dj++CTjlGG6548oH9CSr6AUYHog5P9+Qy3Ngf
	 m0Z6zLcszpRd6KkiahpjrboDKiIPKJFhzWEmseeKCFbr+3SqOQVw83Oi9hYsbugp81
	 DvB9X8hFcKBS9atmAz+KJhruFtWggDrM84C+r2SVoWPc83WzxK8G66+EvfxBgIVN2+
	 KagGMV/PCjWFtK45shyBPfXpPAbU2MKlKk3BuhST2zH+TJ4Mgjh4Sisoq93MR/Gzlc
	 bUy3uNTZht13oO8Q5arcDit8t+FTwM4xSjAhAt+el72cH9+WL4TqZw828E2ofw9R6r
	 L9brxZ2NkDlNQ==
Date: Wed, 19 Nov 2025 14:33:52 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, 
 kever.yang@rock-chips.com, mani@kernel.org, linux-kernel@vger.kernel.org, 
 trix@redhat.com, dev@kael-k.io, neil.armstrong@linaro.org, mdf@kernel.org, 
 heiko@sntech.de, yilun.xu@intel.com, linux-fpga@vger.kernel.org
To: iansdannapel@gmail.com
In-Reply-To: <20251119184708.566461-3-iansdannapel@gmail.com>
References: <20251119184708.566461-1-iansdannapel@gmail.com>
 <20251119184708.566461-3-iansdannapel@gmail.com>
Message-Id: <176358443294.3138094.4409498749262975904.robh@kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: fpga: Add Efinix SPI programming
 bindings


On Wed, 19 Nov 2025 19:47:05 +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add device tree bindings documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  .../bindings/fpga/efinix,trion-spi.yaml       | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/fpga/efinix,spi.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fpga/efinix,trion-spi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251119184708.566461-3-iansdannapel@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

