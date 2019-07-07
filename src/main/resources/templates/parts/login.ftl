<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> User Name:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control ${(usernameError??)?string('is-invalid', '')}" name="username" value="<#if user??>${user.username}</#if>" placeholder="User name"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" class="form-control ${(passwordError??)?string('is-invalid', '')}" name="password" placeholder="Password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Password:</label>
                <div class="col-sm-6">
                    <input type="password" class="form-control ${(passwordConfirmationError??)?string('is-invalid', '')}" name="passwordConfirmation" placeholder="Confirm password"/>
                    <#if passwordConfirmationError??>
                        <div class="invalid-feedback">
                            ${passwordConfirmationError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">e-mail:</label>
                <div class="col-sm-6">
                    <input type="email" class="form-control ${(emailError??)?string('is-invalid', '')}" name="email"  value="<#if user??>${user.email}</#if>" placeholder="em@il.net"/>
                    <#if emailError??>
                        <div class="invalid-feedback">
                            ${emailError}
                        </div>
                    </#if>
                </div>
            </div>
            <div>
                <div class="g-recaptcha" data-sitekey="6LeZeKwUAAAAAD63k_YbkB8QT6dBPQKj56czmjJl"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
            </div>
        </#if>
        <#if !isRegisterForm><a href="/registration">Add new user</a></#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">
            <#if isRegisterForm>Create<#else>Sign In</#if>
        </button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Sign Out</button>
    </form>
</#macro>