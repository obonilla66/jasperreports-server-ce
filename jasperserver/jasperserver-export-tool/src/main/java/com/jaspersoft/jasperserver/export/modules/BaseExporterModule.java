/*
 * Copyright (C) 2005 - 2020 TIBCO Software Inc. All rights reserved.
 * http://www.jaspersoft.com.
 *
 * Unless you have purchased a commercial license agreement from Jaspersoft,
 * the following license terms apply:
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

package com.jaspersoft.jasperserver.export.modules;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;
import java.util.stream.Collectors;

import com.jaspersoft.jasperserver.api.metadata.common.domain.InternalURI;
import com.jaspersoft.jasperserver.api.metadata.user.domain.*;
import com.jaspersoft.jasperserver.api.metadata.user.service.ProfileAttributeGroup;
import com.jaspersoft.jasperserver.api.metadata.user.service.TenantService;
import com.jaspersoft.jasperserver.export.modules.common.ProfileAttributeBean;
import com.jaspersoft.jasperserver.export.modules.repository.RepositoryExportFilter;
import com.jaspersoft.jasperserver.export.modules.repository.beans.RepositoryObjectPermissionBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Element;

import com.jaspersoft.jasperserver.api.JSExceptionWrapper;
import com.jaspersoft.jasperserver.api.common.domain.ExecutionContext;
import com.jaspersoft.jasperserver.api.metadata.common.domain.util.DataContainerStreamUtil;
import com.jaspersoft.jasperserver.export.Parameters;
import com.jaspersoft.jasperserver.export.io.ExportOutput;
import com.jaspersoft.jasperserver.export.io.ObjectSerializer;
import com.jaspersoft.jasperserver.export.util.CommandOut;

import static java.lang.String.format;

/**
 * @author Lucian Chirita (lucianc@users.sourceforge.net)
 * @version $Id$
 */
public abstract class BaseExporterModule extends BasicExporterImporterModule implements ExporterModule {
	private static final Log log = LogFactory.getLog(BaseExporterModule.class);
	
	protected static final CommandOut commandOut = CommandOut.getInstance();
	
	private String id;
	private String everythingArg;
	
	protected ExporterModuleContext exportContext;
	protected Parameters exportParams;
	protected String characterEncoding;
	protected ExportOutput output;
	protected ExecutionContext executionContext;
	protected boolean exportEverything;

	protected String includeAttributes;
	protected String skipAttributeValues;

	protected TenantService tenantService;

	/**
	* Export works on behalf of the <tt>rootTenant</tt>. <tt>rootTenant</tt> equals <tt>null</tt>
	* when superuser is doing export
	*/
	protected Tenant rootTenant;

	//export filter; nothing is filtered by default
	protected RepositoryExportFilter exportFilter;
	protected String includeSettingsArg;

	public void setId(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}

	public void init(ExporterModuleContext moduleContext) {
		this.exportContext = moduleContext;
		this.exportParams = moduleContext.getExportTask().getParameters();
		this.characterEncoding = moduleContext.getCharacterEncoding();
		this.output = moduleContext.getExportTask().getOutput();
		this.executionContext = moduleContext.getExportTask().getExecutionContext();
		this.exportEverything = isExportEverything();

		rootTenant = exportContext.getExportTask().getRootTenant();
	}

	protected boolean isExportEverything() {
		return exportParams.hasParameter(everythingArg);
	}

	public boolean toProcess() {
		return exportEverything || isToProcess();
	}
	
	protected abstract boolean isToProcess();

	protected boolean hasParameter(String name) {
		return exportParams.hasParameter(name);
	}
	
	protected String getParameterValue(String name) {
		return exportParams.getParameterValue(name);
	}
	
	protected String[] getParameterValues(String name) {
		return exportParams.getParameterValues(name);
	}

	public Element getIndexElement() {
		return exportContext.getModuleIndexElement();
	}
	
	protected final void serialize(Object object, String parentPath, String fileName, ObjectSerializer serializer) {
		OutputStream out = getFileOutput(parentPath, fileName);
		BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(out, 16384);

		if (log.isDebugEnabled()) {
			log.debug(format("Serialize object %s, class: %s, parent path: %s, file name: %s",
					object.toString(), object.getClass(), parentPath, fileName));
		}

		boolean closeOut = true;
		try {
			serializer.write(object, bufferedOutputStream, exportContext);
			
			closeOut = false;
			bufferedOutputStream.close();
		} catch (IOException e) {
			log.error(e);
			throw new JSExceptionWrapper(e);
		} finally {
			if (log.isDebugEnabled()) {
				log.debug(format("End of serialization for the file: %s", fileName));
			}
			if (closeOut) {
				try {
					bufferedOutputStream.close();
				} catch (IOException e) {
					log.error(e);
				}
			}
		}
	}

	protected final OutputStream getFileOutput(String parentPath, String fileName) {
		if (log.isDebugEnabled()) {
			log.debug(format("Get file output stream. Parent path: %s, file name: %s", parentPath, fileName));
		}
		try {
			return output.getFileOutputStream(parentPath, fileName);
		} catch (IOException e) {
			log.error(e);
			throw new JSExceptionWrapper(e);
		}
	}
	
	protected final void writeData(InputStream input, String parentPath, String fileName) {
		if (log.isDebugEnabled()) {
			log.debug(format("Write data for the parent path: %s, file name: %s", parentPath, fileName));
		}

		OutputStream out = getFileOutput(parentPath, fileName);
		boolean closeOut = true;
		try {
			DataContainerStreamUtil.pipeData(input, out);
			
			closeOut = false;
			out.close();
		} catch (IOException e) {
			log.error(e);
			throw new JSExceptionWrapper(e);
		} finally {
			if (log.isDebugEnabled()) {
				log.debug(format("Ending of writing data for the parent path: %s, file name: %s", parentPath, fileName));
			}

			if (closeOut) {
				try {
					out.close();
				} catch (IOException e) {
					log.error(e);
				}
			}
		}
	}
	
	protected final void mkdir(String path) {
		if (log.isDebugEnabled()) {
			log.debug(format("Make directory for the path: %s", path));
		}
		try {
			output.mkdir(path);
		} catch (IOException e) {
			log.error(e);
			throw new JSExceptionWrapper(e);
		}
	}
	
	protected final String mkdir(String parentPath, String path) {
		if (log.isDebugEnabled()) {
			log.debug(format("Make directory for parent path: %s, path: %s", parentPath, path));
		}
		try {
			return output.mkdir(parentPath, path);
		} catch (IOException e) {
			log.error(e);
			throw new JSExceptionWrapper(e);
		}
	}

	public String getEverythingArg() {
		return everythingArg;
	}

	public void setEverythingArg(String everythingArg) {
		this.everythingArg = everythingArg;
	}

	public ExecutionContext getExecutionContext() {
		return executionContext;
	}

	public RepositoryObjectPermissionBean[] handlePermissions(InternalURI object) {
		if (log.isDebugEnabled()) {
			log.debug(format("Get object permissions for the object: %s", getObjectURI(object)));
		}

		List permissions = permissionService.getObjectPermissionsForObject(executionContext, object);
		RepositoryObjectPermissionBean[] permissionBeans;
		if (permissions == null || permissions.isEmpty()) {
			permissionBeans = null;
		} else {
			if (log.isDebugEnabled()) {
				log.debug(format("Found %s permissions for %s", permissions.size(), getObjectURI(object)));
			}
			commandOut.debug("Found " + permissions.size() + " permissions for " + object.getURI());
			log.debug("Creating permissions beans");

			permissionBeans = new RepositoryObjectPermissionBean[permissions.size()];
			int c = 0;
			for (Iterator i = permissions.iterator(); i.hasNext(); ++c) {
				ObjectPermission permission = (ObjectPermission) i.next();
				RepositoryObjectPermissionBean permissionBean = toPermissionBean(permission);
				permissionBeans[c] = permissionBean;
			}
		}
		return permissionBeans;
	}

	protected RepositoryObjectPermissionBean toPermissionBean(ObjectPermission permission) {
		if (log.isDebugEnabled()) {
			log.debug("Creating repository object permission bean: " + permission.toString());
		}

		RepositoryObjectPermissionBean permissionBean = new RepositoryObjectPermissionBean();

		permissionBean.setRecipient(toPermissionRecipient(permission.getPermissionRecipient()));
		permissionBean.setPermissionMask(permission.getPermissionMask());

		return permissionBean;
	}

	public ProfileAttributeBean[] prepareAttributesBeans(List<?> userAttributes) {
		if (userAttributes == null || userAttributes.isEmpty()) {
			return null;
		}
		if (log.isDebugEnabled()) {
			final String userAttributesString = userAttributes.stream()
					.map(Object::toString)
					.collect(Collectors.joining(", "));
			log.debug(format("Prepare attributes beans: %s", userAttributesString));
		}

		ArrayList<ProfileAttributeBean> beans = new ArrayList<ProfileAttributeBean>();
		Iterator it = userAttributes.iterator();
		while (it.hasNext()) {
			ProfileAttribute attr = (ProfileAttribute) it.next();
			ProfileAttributeBean bean = new ProfileAttributeBean();
			bean.copyFrom(attr);
			if (attr.getGroup().equals(ProfileAttributeGroup.CUSTOM.toString())) {
				if (!exportEverything && !hasParameter(includeAttributes)) continue;

				if (hasParameter(skipAttributeValues)) {
					bean.setValue("");
				}
			} else {
				if (!exportEverything && !hasParameter(includeSettingsArg)) continue;
			}
			bean.setPermissions(handlePermissions(attr));
			beans.add(bean);
		}
		ProfileAttributeBean[] attributes = new ProfileAttributeBean[beans.size()];
		log.debug("Finished preparing attributes beans");
		return beans.toArray(attributes);
	}

	public void setIncludeAttributes(String includeAttributes) {
		this.includeAttributes = includeAttributes;
	}

	public void setSkipAttributeValues(String skipAttributeValues) {
		this.skipAttributeValues = skipAttributeValues;
	}

	public TenantService getTenantService() {
		return tenantService;
	}

	public void setTenantService(TenantService tenantService) {
		this.tenantService = tenantService;
	}

	public void setExportFilter(RepositoryExportFilter exportFilter) {
		this.exportFilter = exportFilter;
	}

	public void setIncludeSettingsArg(String includeSettingsArg) {
		this.includeSettingsArg = includeSettingsArg;
	}

	private String getObjectURI(InternalURI object) {
		return object != null ? object.getParentURI() : null;
	}
}
